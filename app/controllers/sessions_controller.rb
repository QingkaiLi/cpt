class SessionsController < ApplicationController
  require 'net/http'
  require 'uri'

  CURRENT_CAS_SESSION_COOKIE = "ScientificLearningCurrentCasSessionCookie"

  def index
    redirect_to root_path if current_user
  end

  def create

    principal = get_user_principal
    if principal == nil || !principal['success']
      redirect_to cas_logout_url
      session['error_msg'] = principal['msg']
      return
    end

    enabledDistrict = APP_CONFIG['enabled_district']
    if enabledDistrict.size > 0 && !enabledDistrict.include?(principal['district']['organizationId'])
      redirect_to cas_logout_url
      session['error_msg'] = 'You are not belong to a enabled district!'
      return
    end

    if principal['role'].size < 1
      redirect_to cas_logout_url
      session['error_msg'] = 'You don\'t have permission!'
      return
    end

    user = User.from_omniauth env["omniauth.auth"]
    session[:user_id] = user.id

    redirect_to session[:return_to] || root_url, notice: 'logged in.'
    session.delete(:return_to)
  end

  def destroy
    #User.delete(session[:user_id])
    session[:user_id] = nil
    redirect_to cas_logout_url
  end

private
  def cas_logout_url
    cas_url ||= begin
      uri = Addressable::URI.new
      uri.host = APP_CONFIG['omniauth']['scilearn']['host']
      uri.scheme = APP_CONFIG['omniauth']['scilearn']['ssl'] ? 'https' : 'http'
      uri.port = APP_CONFIG['omniauth']['scilearn']['port']
      uri.path = nil
      uri.to_s
    end

    logout_url ||= begin
      Addressable::URI.parse(APP_CONFIG['omniauth']['scilearn']['logout_url']).tap do |base_uri|
        base_uri.query_values = (base_uri.query_values || {}).merge( {:service => Rack::Utils.escape(root_url)} )
      end.to_s
    end

    cas_url + logout_url
  end

  private
  def get_user_principal
    url = URI("#{APP_CONFIG['msl_url']}/casDataService/findRolesByUserID?TGT=#{cookies[CURRENT_CAS_SESSION_COOKIE]}")
    req = Net::HTTP::Get.new url.to_s
    http = Net::HTTP.new url.host, url.port

    res = http.request(req)
    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      jRes = JSON.parse(res.body);
      return jRes
    else
      return '{\'success\':false, \'msg\':\'connect error\'}'
      #log
    end
    return nil
  end


end

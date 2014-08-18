# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Status.create([
  { name: 'In Progress' },  
  { name: 'Approved' }, 
  { name: 'Published' },
  { name: 'Ready to Review' } ])

AudioStatus.create([
  { name: 'Missing' },  
  { name: 'Needs Review' }, 
  { name: 'Approved' } ])

ContentType.create([
  { name: 'Reading Assistance' }, 
  { name: 'Fluency Assessment' } ])

Since we use directories to seperate components feature, when running cucumber, 
any feature that is located inside a sub-directory of features directory must require features.

e.g.

```bash
cucumber -r features features/manage_topics/add_topic.feature
```

# S3 seeding

To store data to S3 after it has been seeded normally:
```
mysqldump -u root rails_app | gzip -9 > database.sql.gz
aws s3 cp database.sql.gz s3://cs290/LaPlaya/
```
----
To load data from S3 on a new **Single** instance:
```
cd ~/app
rake db:drop
rake db:create
aws s3 cp s3://cs290/LaPlaya/database.sql.gz .
gunzip < database.sql.gz | mysql -u root rails_app
```

To load data from S3 on a new **Multi** instance:
```
cd ~/app
rake db:drop
rake db:create
aws s3 cp s3://cs290/LaPlaya/database.sql.gz .
gunzip < database.sql.gz | mysql -u root -ppassword -h $(grep host ~/app/config/database.yml | cut -c9-) rails_app
```

Nested comments:

https://gist.github.com/jhenkens/4ccaf69c85c296501ab9
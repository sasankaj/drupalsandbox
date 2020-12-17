#!/bin/bash 

source /home/ec2-user/scripts/variables.sh

USER_KEY=$ENVIRONMENT-RDSUSER
RDS_USER=`aws ssm get-parameter --name $USER_KEY --region $AWS_REGION --query Parameter.Value --output text --with-decryption`

PASS_KEY=$ENVIRONMENT-RDSPASSWORD
RDS_PASSWORD=`aws ssm get-parameter --name $PASS_KEY --region $AWS_REGION --query Parameter.Value --output text --with-decryption`

DB_KEY=$ENVIRONMENT-DBNAME
RDS_DBNAME=`aws ssm get-parameter --name $DB_KEY --region $AWS_REGION --query Parameter.Value --output text`

BUCKET_KEY=$ENVIRONMENT-BUCKET
S3_BUCKETNAME=`aws ssm get-parameter --name $BUCKET_KEY --region $AWS_REGION --query Parameter.Value --output text`

#sudo mysqldump -u $RDS_USER -p$RDS_PASSWORD -h $RDS_HOST $RDS_DBNAME > /home/ec2-user/pipeline/sql.sql

#sudo zip /home/ec2-user/pipeline/sql.zip /home/ec2-user/pipeline/sql.sql

#today=`date '+%Y_%m_%d__%H_%M_%S'`;

#aws s3 cp /home/ec2-user/pipeline/sql.zip s3://$S3_BUCKETNAME/codepipeline_db/$today.zip

#sudo rm /home/ec2-user/pipeline/sql.sql
#sudo rm /home/ec2-user/pipeline/sql.zip
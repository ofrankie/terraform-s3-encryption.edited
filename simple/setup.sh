#!/bin/bash


for BUCKET in $(aws  s3api list-buckets --output table --query 'Buckets[*].Name' | grep dev-de-secure | sed -e 's/ // g' -e 's/|//g')
do
  aws s3 cp ../terraform/data/dev/SMK_FFB_SOAP_CERT_KEY s3://$BUCKET/SMK_FFB_SOAP_CERT_KEY
  aws s3 cp ../terraform/data/dev/SMK_FFB_SOAP_CLIENT_PRIVATE_KEY s3://$BUCKET/SMK_FFB_SOAP_CLIENT_PRIVATE_KEY
done


for BUCKET in $(aws  s3api list-buckets --output table --query 'Buckets[*].Name' | grep qa-de-secure | sed -e 's/ // g' -e 's/|//g')
do
  aws s3 cp ../terraform/data/qa/SMK_FFB_SOAP_CERT_KEY s3://$BUCKET/SMK_FFB_SOAP_CERT_KEY
  aws s3 cp ../terraform/data/qa/SMK_FFB_SOAP_CLIENT_PRIVATE_KEY s3://$BUCKET/SMK_FFB_SOAP_CLIENT_PRIVATE_KEY
done

for BUCKET in $(aws  s3api list-buckets --output table --query 'Buckets[*].Name' | grep prod-de-secure | sed -e 's/ // g' -e 's/|//g')
do
  aws s3 cp ../terraform/data/prod/SMK_FFB_SOAP_CERT_KEY s3://$BUCKET/SMK_FFB_SOAP_CERT_KEY
  aws s3 cp ../terraform/data/prod/SMK_FFB_SOAP_CLIENT_PRIVATE_KEY s3://$BUCKET/SMK_FFB_SOAP_CLIENT_PRIVATE_KEY
done



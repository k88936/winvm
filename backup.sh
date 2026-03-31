set -a
source .env
set +a
# aws s3 cp winvm-compact.qcow2 s3://software-release/winvm/0.0.1/winvm-compact.qcow2 --endpoint-url http://localhost:10900
# aws s3 cp winvm.qcow2 s3://software-release/winvm/0.0.3/winvm.qcow2 --endpoint-url http://localhost:10900
# aws s3 cp winvm.qcow2 s3://software-release/winvm/0.0.4/winvm.qcow2 --endpoint-url http://localhost:10900
aws s3 cp winvm.qcow2 s3://software-release/winvm/0.0.5/winvm.qcow2 --endpoint-url http://localhost:10900
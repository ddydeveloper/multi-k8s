docker build -t ddydeveloper/multi-client:latest -t ddydeveloper/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ddydeveloper/multi-server:latest -t ddydeveloper/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ddydeveloper/multi-worker:latest -t ddydeveloper/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ddydeveloper/multi-client:latest
docker push ddydeveloper/multi-server:latest
docker push ddydeveloper/multi-worker:latest

docker push ddydeveloper/multi-client:$SHA
docker push ddydeveloper/multi-server:$SHA
docker push ddydeveloper/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ddydeveloper/multi-server:$SHA
kubectl set image deployments/client-deployment client=ddydeveloper/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ddydeveloper/multi-worker:$SHA
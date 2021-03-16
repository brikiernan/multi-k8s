docker build -t briankiernan/multi-client:latest -t briankiernan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t briankiernan/multi-server:latest -t briankiernan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t briankiernan/multi-worker:latest -t briankiernan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push briankiernan/multi-client:latest
docker push briankiernan/multi-server:latest
docker push briankiernan/multi-worker:latest

docker push briankiernan/multi-client:$SHA
docker push briankiernan/multi-server:$SHA
docker push briankiernan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=briankiernan/multi-client:$SHA
kubectl set image deployments/server-deployment server=briankiernan/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=briankiernan/multi-worker:$SHA
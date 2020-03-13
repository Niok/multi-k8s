docker build -t niok/multi-client:latest -t niok/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t niok/multi-server:latest -t niok/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t niok/multi-worker:latest -t niok/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push niok/multi-client:latest
docker push niok/multi-server:latest
docker push niok/multi-worker:latest
docker push niok/multi-client:$SHA
docker push niok/multi-server:$SHA
docker push niok/multi-worker:$HA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=niok/multi-client:$SHA
kubectl set image deployments/server-deployment server=niok/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=niok/multi-worker:$SHA
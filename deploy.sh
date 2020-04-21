docker build -t cherubini/multi-client:latest  -t cherubini/multi-client:$SHA -f ./client/Dockerfile .client
docker build -t cherubini/multi-server:latest -t cherubini/multi-server:$SHA -f ./server/Dockerfile .server
docker build -t cherubini/multi-worker:latest -t cherubini/multi-worker:$SHA -f ./worker/Dockerfile .worker

docker push cherubini/multi-client:latest
docker push cherubini/multi-serve:latest
docker push cherubini/multi-worker:latest

docker push cherubini/multi-client:$SHA
docker push cherubini/multi-serve:$SHA
docker push cherubini/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployment/server-deployment server=cherubini/multi-server:$SHA
kubectl set image deployment/client-deployment client=cherubini/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=cherubini/multi-worker:$SHA
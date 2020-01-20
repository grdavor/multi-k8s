docker build -t grdavor/multi-client:latest -t grdavor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t grdavor/multi-server:latest -t grdavor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t grdavor/multi-worker:latest -t grdavor/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push grdavor/multi-client:latest
docker push grdavor/multi-server:latest
docker push grdavor/multi-worker:latest

docker push grdavor/multi-client:$SHA
docker push grdavor/multi-server:$SHA
docker push grdavor/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=grdavor/multi-server:$SHA
kubectl set image deployments/client-deployment client=grdavor/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=grdavor/multi-worker:$SHA

# kubectl rollout restart deployment/server-deployment
# kubectl rollout restart deployment/client-deployment
# kubectl rollout restart deployment/worker-deployment

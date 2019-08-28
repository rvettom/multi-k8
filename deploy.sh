docker build -t rvettom/multi-client:latest -t rvettom/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rvettom/multi-server:latest -t rvettom/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rvettom/multi-worker:latest -t rvettom/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rvettom/multi-client:latest
docker push rvettom/multi-server:latest
docker push rvettom/multi-worker:latest

docker push rvettom/multi-client:$SHA
docker push rvettom/multi-server:$SHA
docker push rvettom/multi-worker:$SHA

kubectl set image deployment/server-deployment server=rvettom/multi-server$SHA
kubectl set image deployment/client-deployment client=rvettom/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=rvettom/multi-worker:$SHA
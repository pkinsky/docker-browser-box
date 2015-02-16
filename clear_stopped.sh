# remove stopped containers
echo "Removing stopped containers..."
for c in $(docker ps -a -q)
do
  image="$(docker inspect -f {{.Config.Image}} ${c})"
  running=$(docker inspect -f {{.State.Running}} ${c})
  if [ "${running}" != "true" ]; then
      echo rm ${c}
      docker rm "${c}" >/dev/null
  fi
done

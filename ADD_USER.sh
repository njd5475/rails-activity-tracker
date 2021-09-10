#!/bin/bash

PWD=${DATABASE_PWD:-apassword}

docker exec -it rails-activity-tracker_db_1  psql -U postgres -c "CREATE USER railstime_dev WITH PASSWORD '$PWD'"
docker exec -it rails-activity-tracker_db_1  psql -U postgres -c "alter role railstime_dev superuser createrole createdb replication;"

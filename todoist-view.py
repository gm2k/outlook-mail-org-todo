import todoist
import sys

# Todoist API - first argument in commandline
api = todoist.TodoistAPI(sys.argv)
response = api.sync()
for project in response['Projects']:
    print(project['name'])
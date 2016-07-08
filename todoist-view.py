from pytodoist.api import TodoistAPI
from pytodoist import todoist
import sys
import os

user_login = sys.argv[1]
user_password = sys.argv[2]
org_folder = sys.argv[3]
user = todoist.login(user_login, user_password)

def main():
    projects = user.get_projects()
    for project in projects:
        print("* "+project.name)
        tasks = project.get_tasks()
        for task in tasks:
            print("**" + task.content.encode('cp866','replace'))




if __name__ == '__main__':
    main()
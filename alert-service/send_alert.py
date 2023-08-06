#!/home/aarya/pyvenv/bin/python3
import smtplib
import ssl
import os
from dotenv import load_dotenv
from datetime import datetime, timedelta
from jinja2 import Template
import pytodotxt
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

load_dotenv()


def send_mail(subject, content_text, content_html):
    host = "smtp.gmail.com"
    port = 465
    password = str(os.getenv('GOOGLE_APP_PASSWORD') or "")

    sender_name = "Alert Service"
    sender_email = "aaryab.alertservice@gmail.com"
    receiver_name = "Aarya Bhatia"
    receiver_email = "aarya.bhatia1678@gmail.com"

    context = ssl.create_default_context()

    if content_html:
        message = MIMEMultipart()
        message["From"] = f"{sender_name} <{sender_email}>\n"
        message["To"] = f"{receiver_name} <{receiver_email}>\n"
        message["Subject"] = f"{subject}\n"

        html_body = MIMEText(content_html, "html")
        message.attach(html_body)

        with smtplib.SMTP_SSL(host, port, context=context) as server:
            server.login(sender_email, password)
            server.sendmail(sender_email, receiver_email, message.as_string())
            print("Successfully sent email")

    elif content_text:
        message = ""
        message += f"From: {sender_name} <{sender_email}>\n"
        message += f"To: {receiver_name} <{receiver_email}>\n"
        message += f"Subject: {subject}\n"
        message += "\n"
        message += content_text

        with smtplib.SMTP_SSL(host, port, context=context) as server:
            server.login(sender_email, password)
            server.sendmail(sender_email, receiver_email, message)
            print("Successfully sent email")


def main():
    TODO_DIR = str(os.getenv("TODO_DIR"))
    todotxt = pytodotxt.TodoTxt(os.path.join(TODO_DIR, "todo.txt"))
    todotxt.parse()

    today_tasks = []
    tomorrow_tasks = []
    priority_tasks = {"high": [], "normal": [], "low": []}
    high_pri = ["A", "B"]
    normal_pri = ["C"]

    today = datetime.now()
    tomorrow = today + timedelta(days=1)

    for task in todotxt.tasks:
        if task.is_completed:
            continue

        try:
            if task.attributes and task.attributes["due"]:
                due = task.attributes["due"][0]
                date = datetime.strptime(due, "%Y-%m-%d")

                if date <= today:
                    today_tasks.append(task)
                elif date <= tomorrow:
                    tomorrow_tasks.append(task)
            elif task.priority:
                if task.priority in high_pri:
                    priority_tasks["high"].append(task)
                elif task.priority in normal_pri:
                    priority_tasks["normal"].append(task)
                else:
                    priority_tasks["low"].append(task)
        except:
            print(f"ERR: {task}")

    with open("template.txt", "r") as file:
        template = file.read()

        rendered = Template(template).render({
            "today_tasks": today_tasks,
            "today_date": today.strftime("%d %b"),
            "tomorrow_tasks": tomorrow_tasks,
            "tomorrow_date": tomorrow.strftime("%d %b"),
            "high_priority": priority_tasks["high"],
            "normal_priority": priority_tasks["normal"],
            "low_priority": priority_tasks["low"]
        })

        send_mail("[ALERT] Reminders for upcoming tasks", rendered, None)


if __name__ == "__main__":
    # send_mail("This is a test e-mail message. Do not reply to this email.\n")

    main()

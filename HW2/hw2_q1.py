import urllib.request
import re
import matplotlib.pyplot as plt

author = input("Input Author: ")
author = author.replace(" ", "+")
url = "https://arxiv.org/search/?query=" + author + "&searchtype=author&abstracts=hide&order=announced_date_first&size=200"
content = urllib.request.urlopen(url)
html_str = content.read().decode('utf-8')
# pattern = 'is-size-7[\s\S]*?</p>'
pattern = 'originally announced</span>[\s\S]*?</p>'
result = re.findall(pattern, html_str)

year = []
times = []
start = 0
count = -1
print("[ Author: " + author + " ]")
for r in result:
    title = r.split("originally announced</span>")[1].split("</p>")[0].strip()
    # print(title)
    y = title.split(' ')[1].split('.')[0]
    # print(y)
    if y == start:
        times[count] += 1
    else:
        start = y
        year.append(start)
        times.append(0)
        count += 1
        times[count] += 1

# start = result[0].split("originally announced</span>")[1].split("</p>")[0].strip().split(' ')[1].split('.')[0]
print(year)
print(times)
# print(len(year))
plt.bar(year, times)
plt.show()

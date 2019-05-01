import urllib.request
import re
import matplotlib.pyplot as plt

author = input("Input Author: ")
author_sp = author.replace(" ", "+")
size = 100
page = 0
error = "produced no results"
temp = []
result = []
while 1:
    # all 100 articles
    url = "https://arxiv.org/search/?query=" + author_sp + "&searchtype=author&abstracts=hide&order=announced_date_first&size=" + str(size) + "&start=" + str(page)
    content = urllib.request.urlopen(url)
    html_str = content.read().decode('utf-8')
    # if no articles in this page
    if error in html_str:
        break
    # find out all articles
    pattern = 'arxiv-result[\s\S]*?</li>'
    temp = re.findall(pattern, html_str)
    count = 0
    # for each article, compare the authors
    for t in temp:
        pattern = 'Authors:</span>[\s\S]*?</p>'
        # find the author area
        temp1 = re.findall(pattern, t)
        # if there's no author's name, continue
        if author not in temp1[0]:
            # count += 1
            continue
        # if in the list, find the year
        else:
            pattern = 'originally announced</span>[\s\S]*?</p>'
            result.extend(re.findall(pattern, t))
    page += size
# print(count)
year_dict = {}
print("[ Author: " + author + " ]")
for r in result:
    year = r.split("originally announced</span>")[1].split("</p>")[0].strip()
    y = year.split(' ')[1].split('.')[0]

    if y not in year_dict:
        year_dict[y] = 1
    else:
        year_dict[y] += 1

years = []
times = []
for key, values in year_dict.items():
    years.append(key)
    times.append(values)

plt.bar(years, times)
plt.show()
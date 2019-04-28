import urllib.request
import re
import collections

author = input("Input Author: ")
w_author = author.replace(" ", "+")
url = "https://arxiv.org/search/?query=" + w_author + "&searchtype=author&abstracts=hide&order=announced_date_first&size=200"
content = urllib.request.urlopen(url)
html_str = content.read().decode('utf-8')
pattern = 'Authors:</span>[\s\S]*?</p>'
result = re.findall(pattern, html_str)

print("Author: " + author + "")

authors = {}
pattern = '\">[\s\S]*?</a>'
for r in result:
    temp = re.findall(pattern, r)
    for t in temp:
        people = t.split("\">")[1].split("</a>")[0].strip()
        if people != author:
            if people in authors:
                authors[people] += 1
            elif people not in authors:
                authors[people] = 1

ordered_author = collections.OrderedDict(sorted(authors.items()))
for i in ordered_author.items():
    output = "%s: %.2d times" %(i[0], i[1])
    print(output)
import urllib.request
import re
import collections

author = input("Input Author: ")
w_author = author.replace(" ", "+")
size = 100
page = 0
error = "produced no results"
# go through all the pages
while 1:
    url = "https://arxiv.org/search/?query=" + w_author + "&searchtype=author&abstracts=hide&order=announced_date_first&size=" + str(size) + "&start=" + str(page)
    content = urllib.request.urlopen(url)
    html_str = content.read().decode('utf-8')
    # if no articles in this page
    if error in html_str:
        break
    # find out the author area
    pattern = 'Authors:</span>[\s\S]*?</p>'
    result = re.findall(pattern, html_str)
    page += size

authors = {}
pattern = '\">[\s\S]*?</a>'

# for each article
for r in result:
    # find out every author
    temp = re.findall(pattern, r)
    count = 0
    # for each author, compare to determine if this article is useless
    for t in temp:
        # split
        people = t.split("\">")[1].split("</a>")[0].strip()
        # if not the autor's name, count++
        if people != author:
            count += 1
    # if count != the length of the list, then put the authors in the dict
    # else continue
    if count != len(temp):
        for t in temp:
            people = t.split("\">")[1].split("</a>")[0].strip()
            # authors except for heself
            if people != author:
                # already in dict
                if people in authors:
                    # plus 1
                    authors[people] += 1
                # else update
                else:
                    authors[people] = 1
# sort by the keys(names)
ordered_author = collections.OrderedDict(sorted(authors.items()))

#print out the ans
for i in ordered_author.items():
    output = "%s: %.2d times" %(i[0], i[1])
    print(output)
# print(len(ordered_author))
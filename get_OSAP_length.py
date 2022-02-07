#!/usr/bin/env python
# coding: utf-8

# In[5]:


import numpy as np
import heapq
import matplotlib.pyplot as plt
from matplotlib.pyplot import figure

import subprocess
import sys
import re


# In[6]:


target = sys.argv[1]
output = sys.argv[2]

target_instance  = open(target)                
output_instance  = open(output, "w")


# In[7]:


find_nodes   = re.compile("(init\(object\(node).*$" )
find_robots  = re.compile("(init\(object\(robot).*$" )
find_destinations   = re.compile("(init\(object\(destination).*$" )


# In[15]:


grid = np.ones((350,350))

robots = []
destinations = []

lines = target_instance.readlines()



for line in lines:
    output_instance.write(line)

    if find_nodes.match(line):
        coordinate = np.array(re.findall(r'[-\d]+', line)).astype(int)[1:]
        grid[coordinate[0],coordinate[1]] = 0
        
    if find_robots.match(line):
        
        robots.append(list(map(int, re.findall(r'[-\d]+', line)[1:])))
            
    if find_destinations.match(line):
        
        destinations.append(list(map(int, re.findall(r'[-\d]+', line)[1:])))

target_instance.close()


# In[10]:



##############################################################################

# heuristic function for path scoring

##############################################################################

 

def heuristic(a, b):

    return np.sqrt((b[0] - a[0]) ** 2 + (b[1] - a[1]) ** 2)

 

##############################################################################

# path finding function

##############################################################################

 

def astar(array, start, goal):

    neighbors = [(0,1),(0,-1),(1,0),(-1,0)]

    close_set = set()

    came_from = {}

    gscore = {start:0}

    fscore = {start:heuristic(start, goal)}

    oheap = []

    heapq.heappush(oheap, (fscore[start], start))
 

    while oheap:

        current = heapq.heappop(oheap)[1]

        if current == goal:

            data = []

            while current in came_from:

                data.append(current)

                current = came_from[current]

            return data

        close_set.add(current)

        for i, j in neighbors:

            neighbor = current[0] + i, current[1] + j

            tentative_g_score = gscore[current] + heuristic(current, neighbor)

            if 0 <= neighbor[0] < array.shape[0]:

                if 0 <= neighbor[1] < array.shape[1]:                

                    if array[neighbor[0]][neighbor[1]] == 1:

                        continue

                else:

                    # array bound y walls

                    continue

            else:

                # array bound x walls

                continue
 

            if neighbor in close_set and tentative_g_score >= gscore.get(neighbor, 0):

                continue
 

            if  tentative_g_score < gscore.get(neighbor, 0) or neighbor not in [i[1]for i in oheap]:

                came_from[neighbor] = current

                gscore[neighbor] = tentative_g_score

                fscore[neighbor] = tentative_g_score + heuristic(neighbor, goal)

                heapq.heappush(oheap, (fscore[neighbor], neighbor))
 

    return False




target_instance = open(target,"a")

for agent in range(len(robots)):
    start = tuple(robots[agent])
    goal = tuple(destinations[agent])

    route = astar(grid, start, goal)

    route = route + [start]

    route = route[::-1]

    string = "priority(robot("+str(agent+1)+"),"+str(len(route))+").\n"
    target_instance.write(string)

target_instance.close()
output_instance.close()


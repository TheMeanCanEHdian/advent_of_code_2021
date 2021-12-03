import os

__location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
with open(os.path.join(__location__,'input.txt')) as file:
    measurements = file.readlines()
    measurements = [int(measurement.rstrip()) for measurement in measurements]

#  Part 1
num_times_larger = 0
for index, measurement in enumerate(measurements):
    if index > 0:
        if measurement > measurements[index - 1]:
            num_times_larger += 1
print(num_times_larger)

# Part 2
window_measurements = []

for index, measurement in enumerate(measurements):
    if index < len(measurements) - 2:
        window_sum = measurement + measurements[index + 1] + measurements[index + 2]
        window_measurements.append(window_sum)

num_times_larger = 0
for index, measurement in enumerate(window_measurements):
    if index > 0:
        if measurement > window_measurements[index - 1]:
            num_times_larger += 1
print(num_times_larger)

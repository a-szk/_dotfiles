#!/bin/bash


convert +append 1.png 2.png 3.png 4.png a1.png
convert +append 5.png 6.png 7.png 8.png a2.png
convert +append 9.png 10.png 11.png 12.png a3.png

convert -append a1.png a2.png a3.png a.png

#!/bin/bash

iverilog Ejer1.v Ejer1_tb.v -o test1
vvp test1
rm -f test1
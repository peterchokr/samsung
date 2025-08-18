# 따로 만든 fibo.py 모듈을 사용하는 예

# 1
import fibo

fibo.fib(1000)
print(fibo.fib2(100))

# 2
from fibo import fib
fib(1000)

#3
from fibo import *
fib(500)

class A:
    def __init__(self):
        super().__init__()
        print(super())
        print("__init_a__")
class B:
    # print("cao")
    def __init__(self):
        super().__init__()
        print(super())
        print("__int_b__")


class X(A, B):
    def __init__(A, B ,self):
        super().__init__()
        print(super())
        print("__int_x__")

a = A()
# print(a)
b = B()
# print(b)
x = X(a, b)
# print(x)
print(super.__dict__)
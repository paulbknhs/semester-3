import unittest
from collections import deque

# Hier bitte den Namen und die Matrikelnummer *aller* Gruppenmitglieder eintrage:
# | Name                          | Matrikelnummer
# ---------------------------------------------------------
# |                               | 
# |                               | 
# |                               | 
# |                               | 

class Stack(deque):
    """ADT Stack"""

    def top(self):
        return self[-1]
    
    def pop(self):
        return super().pop()
    
    def push(self, e):
        self.append(e)

class Queue(deque):
    """ADT Queue"""

    def front(self):
        return self[0]
    
    def dequeue(self):
        return self.popleft()
    
    def enqueue(self, e):
        self.append(e)


# Aufgabe 2
def dfs_tree(graph:list[list[int]], s:int) -> list[list[int]]:
    pass


# Aufgabe 3
def zweiteilbar(graph:list[list[int]]) -> (list[int], list[int]):
    pass


# Unit Tests
class TestExercise2(unittest.TestCase):
    def test_bfs_tree1(self):
        g = [[0, 1, 2, 3],\
             [0, 1, 2, 3],\
             [0, 1, 2, 3],\
             [0, 1, 2, 3]]
        g_sol = [[3], [], [1], [2]]

        self.assertEqual(dfs_tree(g, 0), g_sol)

    def test_bfs_tree2(self):
        g = [[0, 2],\
             [0, 1, 2],\
             [0, 1, 2, 3],\
             [0, 1, 2, 3]]
        g_sol = [[2], [], [3], [1]]

        self.assertEqual(dfs_tree(g, 0), g_sol)

    def test_bfs_tree3(self):
        g = [[1, 3],\
             [5],\
             [5],\
             [],\
             [1, 2],\
             [2, 3, 4]]
        g_sol = [[3, 1], [5], [], [], [2], [4]]

        self.assertEqual(dfs_tree(g, 0), g_sol)

class TestExercise3(unittest.TestCase):
    def test_zweiteilbar1(self):
        g = [[0, 1, 2, 3],\
             [0, 1, 2, 3],\
             [0, 1, 2, 3],\
             [0, 1, 2, 3]]

        self.assertIs(zweiteilbar(g), None)

    def test_zweiteilbar2(self):
        g = [[1, 5],\
             [0, 2, 3],\
             [1, 4],\
             [1, 4, 5],\
             [2, 3],\
             [0, 3]]
        A, B = set([0, 2, 3]), set([1, 4, 5])
        a, b = zweiteilbar(g)

        self.assertIn((set(a), set(b)), [(A, B), (B, A)])

if __name__ == '__main__':
    runner = unittest.TextTestRunner()
    print("---------------- Test Exercise 2 ----------------")
    runner.run(unittest.TestLoader().loadTestsFromTestCase(TestExercise2))
    print("---------------- Test Exercise 3 ----------------")
    runner.run(unittest.TestLoader().loadTestsFromTestCase(TestExercise3))
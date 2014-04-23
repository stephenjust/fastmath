import unittest
from mathengine.problemTypes.problem import Problem

RANDOM_VAL = 123456

class TestProblem(unittest.TestCase):

    def setUp(self):
        self.problem = Problem(RANDOM_VAL)

    def test_random_seed(self):
        self.assertEqual(RANDOM_VAL, self.problem.random_seed)

if __name__ == '__main__':
    unittest.main()
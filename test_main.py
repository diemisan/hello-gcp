import unittest

from main import dummy


class TestMain(unittest.TestCase):
    def test_dummy(self):
        result = dummy(1)
        self.assertEqual(result, 2)

if __name__ == '__main__':
    unittest.main()
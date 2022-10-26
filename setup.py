from setuptools import setup

setup(
    name='AutoHashcat',
    version='1.0.0',
    py_modules=['AutoHashcat'],
    install_requires=[
        'click',
        'colorama'
    ],
    entry_points={
        'console_scripts': [
            'AutoHashcat = AutoHashcat:AutoHashcat',
        ],
    },
)
from setuptools import setup, find_packages

setup(
    name='AutoHashcat',
    version='1.0.0',
    packages=find_packages(),
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
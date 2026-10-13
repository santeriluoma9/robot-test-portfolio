"""A tiny custom keyword library written in Python.

Robot Framework turns every public function in this file into a keyword:
``build_post_payload`` becomes the keyword ``Build Post Payload``.

Import it in a test file with:

    Library    ${CURDIR}/../../libraries/testdata.py

TODO: add 2-3 keywords of your own here (see the roadmap in README.md).
"""
import random
import string


def random_text(length=8):
    """Return a random lowercase string. Example: ``Random Text    12``."""
    return "".join(random.choices(string.ascii_lowercase, k=int(length)))


def build_post_payload(title=None, body=None, user_id=1):
    """Return a dict that can be sent as JSON to the ``/posts`` endpoint.

    Any value you do not give is generated, so every test gets unique data.
    """
    return {
        "title": title or f"title-{random_text()}",
        "body": body or f"body-{random_text(20)}",
        "userId": int(user_id),
    }

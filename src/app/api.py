from . import models as m


def get_example(example_id):
    try:
        return m.Example.objects.get(id=example_id)
    except m.Example.DoesNotExist:
        return

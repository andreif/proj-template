from django.db import models as m


class _Model(m.Model):
    created_at = m.DateTimeField(auto_created=True, auto_now_add=True)
    updated_at = m.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


# class Example(_Model):
#     name = m.CharField(max_length=255, unique=True)
#     content = m.TextField(null=True, blank=True)
#     from_item = m.ForeignKey(to=Item, related_name='parents', on_delete=m.DO_NOTHING)
#     to_item = m.ForeignKey(to=Item, related_name='children', on_delete=m.DO_NOTHING)
#
#     class Meta:
#         constraints = [
#             m.UniqueConstraint(fields=['from_item', 'to_item'], name='unique_together'),
#             m.CheckConstraint(check=~m.Q(from_item=m.F('to_item')), name='can_not_be_equal'),
#         ]
#
#     def __str__(self):
#         return self.name
#
#     @property
#     def url(self):
#         from .urls import urls
#         return urls.example(example=self)

from django.contrib import admin
from . import models as m


# class ParentsInline(admin.StackedInline):
#     model = m.Relation
#     fk_name = "from_item"
#     extra = 0
#     can_delete = False
#
#
# class ChildrenInline(admin.StackedInline):
#     model = m.Relation
#     fk_name = "to_item"
#     extra = 0
#     can_delete = False
#
#
# @admin.register(m.Example)
# class ExampleAdmin(admin.ModelAdmin):
#     inlines = [
#         ParentsInline,
#         ChildrenInline,
#     ]

from rest_framework.serializers import ModelSerializer

from materials.models import Course, Lesson


class CourseSerializer(ModelSerializer):
    class meta:
        model = Course
        fields = '__all__'

class LessonSerializer(ModelSerializer):
    class meta:
        model = Lesson
        fields = '__all__'

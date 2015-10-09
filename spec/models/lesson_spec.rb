describe Lesson do

  REQUIRED_LESSON_ATTRIBUTES = %i( key title categories project slides )

  describe '.all' do

    context 'when passed a nil user and disabling caching' do
      before(:each) { @lessons = Lesson.all(nil, from_cache: false) }

      it 'returns an array of lessons' do
        expect(@lessons).to be_an(Array)
        @lessons.each do |lesson|
          expect(lesson).to be_a(Lesson)
        end
      end

      describe 'each lesson' do

        it 'has all the required attributes' do
          @lessons.each do |lesson|
            REQUIRED_LESSON_ATTRIBUTES.each do |attribute|
              expect(lesson.public_methods).to include(attribute)
            end
          end
        end

      end
    end
  end

  describe '.where' do

    context 'when passed "{key: static-laptop-setup"}, a nil user, and disabling caching' do
      before(:each) { @lessons = Lesson.where({key: 'static-laptop-setup'}, nil, from_cache: false) }

      it 'returns an array with 1 lesson' do
        expect(@lessons).to be_an(Array)
        expect(@lessons.size).to eq(1)
        expect(@lessons.first).to be_a(Lesson)
      end

      describe 'each lesson' do

        it 'has all the required attributes' do
          @lessons.each do |lesson|
            REQUIRED_LESSON_ATTRIBUTES.each do |attribute|
              expect(lesson.public_methods).to include(attribute)
            end
          end
        end

      end
    end
  end

  describe '.find' do

    context 'when passed the key "static-laptop-setup", a nil user, and disabling caching' do
      before(:each) { @lesson = Lesson.find('static-laptop-setup', nil, from_cache: false) }

      it 'returns a lesson object' do
        expect(@lesson).to be_a(Lesson)
      end

      describe 'the lesson object' do

        it 'has all the required attributes' do
          REQUIRED_LESSON_ATTRIBUTES.each do |attribute|
            expect(@lesson.public_methods).to include(attribute)
          end
        end

      end
    end
  end
end

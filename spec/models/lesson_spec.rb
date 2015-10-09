describe Lesson, type: :model do

  describe '.all' do
    context 'when passed a nil user and forcing from cache' do
      before(:each) { @lessons = Lesson.all(nil, from_cache: false) }

      it 'should be an array' do
        expect(@lessons).to be_an(Array)
      end
    end
  end
end

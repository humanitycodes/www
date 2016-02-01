module TestimonialsHelper
  TESTIMONIALS = [
    "The Lansing Code Lab has not only taught me to code, but more importantly it's shown me how to implement and deploy that code to create actual web sites and applications. I've gained experience in the full set of development and coding tools, which is something you don't get in most of the online coding classes that are available.",
    "Being a part of the Lansing Code Lab has been a great experience. I always look forward to classes. The lessons are well designed and the learning progresses in an intuitive way. Even complete beginners can quickly become proficient and create things. It's exciting to have an idea and be able to turn it into reality. The instructors and mentors are knowledgeable, helpful, and very accessible.",
    "This is the most fun class that I have taken at MSU (and it isn't even at MSU!). I know these skills will be beneficial even if they only help me figure out how to solve computer problems with the help of websites and the users that visit them. The peer support is unmatched. I plan on being a part of Code Lab until I graduate!"
  ]

  def testimonials number
    TESTIMONIALS.sample(number || TESTIMONIALS.size)
  end

end

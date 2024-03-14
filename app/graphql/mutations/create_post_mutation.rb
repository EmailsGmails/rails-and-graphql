module Mutations
  class CreatePostMutation < BaseMutation
    argument :title, String, required: true
    argument :content, String, required: true
    argument :user_id, ID, required: true

    field :post, Types::PostType, null: true
    field :errors, [String], null: false

    def resolve(title:, content:, user_id:)
      user = User.find_by(id: user_id)
      if user
        post = user.posts.build(title: title, content: content)
        if post.save
          { post: post, errors: [] }
        else
          { post: nil, errors: post.errors.full_messages }
        end
      else
        { post: nil, errors: ["User not found"] }
      end
    end
  end
end

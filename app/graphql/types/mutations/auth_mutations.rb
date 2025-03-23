module Types
  module Mutations
    module AuthMutations
      extend ActiveSupport::Concern
      include GraphQL::Types

      included do
        # # # sign in
        field :sign_in, Objects::User, "Sign in", null: true do
          argument :input, Inputs::SignInInput, required: true
        end
        def sign_in(input:)
          handle UserSignInMutation.run(input.to_h)
        end

        # # # sign up
        field :sign_up, Objects::User, "Sign up", null: true do
          argument :input, Inputs::SignUpInput, required: true
        end
        def sign_up(input:)
          handle UserSignUpMutation.run(input.to_h)
        end

        # # # forget password
        field :forget_password, Boolean, "Forget password", null: false do
          argument :input, Inputs::ForgotPasswordInput, required: true
        end
        def forget_password(input:)
          handle ForgetPasswordMutation.run(input.to_h)
        end

        # # # reset password
        field :reset_password, Boolean, "Reset password", null: false do
          argument :input, Inputs::ResetPasswordInput, required: true
        end
        def reset_password(input:)
          handle ResetPasswordMutation.run(input.to_h)
        end

        # # # update user
        field :update_user, Objects::User, "Update User", null: false do
          argument :input, Inputs::UserUpdateInput, required: true
        end
        def update_user(input:)
          handle UserUpdateMutation.run(
                   input.to_h.merge(user: context[:current_user])
                 )
        end
      end
    end
  end
end

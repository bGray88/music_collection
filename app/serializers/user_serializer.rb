class UserSerializer
  def self.users(users)
    {
      "data": users.map do |user|
        {
          "id":         user[:id],
          "type":       "User",
          "attributes": {
            "first_name": user[:first_name],
            "last_name":  user[:last_name],
            "email":      user[:email]
          }
        }
      end
    }
  end
end

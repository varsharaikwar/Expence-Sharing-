module UsersHelper

  # def render_all_balances( group, user )
  #   user.balance(group).each do |balance|
  #     render_balance( group, user, balance)
  #   end
  # end

  def render_balance( group, user, original_balance )
    user_b = User.find(original_balance[:user_id])
    balance = original_balance[:balance]
    output = ""
    you_link = link_to 'You', group_user_path(@group, current_user)
    user_b_link = link_to user_b.name, group_user_path(@group, user_b)
    if balance.negative?
      amount_span = content_tag(:span, ('%.02f' % balance.abs), class: 'red' )
      if user == current_user
        output = "You owe #{user_b_link} "
      elsif user_b == current_user
        output = "#{@user.name} owes you "
      else
        output = "#{@user.name} owes #{user_b_link} "
      end
      return content_tag(:p, (output += amount_span).html_safe)
    elsif balance > 0
      amount_span = content_tag(:span, ('%.02f' % balance.abs), class: 'green' )
      if user == current_user
        output = "#{user_b_link} owes You "
      elsif user_b == current_user
        output = "You owe #{@user.name} "
      else
        output = "#{user_b_link} owes #{@user.name} "
      end

      return content_tag(:p, (output += amount_span).html_safe)
    elsif balance == 0
      if user == current_user
        output = "You and #{user_b_link} are square"
      elsif user_b == current_user
        output = "#{user.name} and #{you_link} are square"
      else
        output = "#{user.name} and #{user_b_link} are square"
      end
      return content_tag(:p, output.html_safe)
    end


  end

end

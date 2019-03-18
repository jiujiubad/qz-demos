class NavigationScreen < PM::TableScreen

  def on_load
    rmq.stylesheet = NavigationScreenStylesheet
  end

  def table_data

    [{
      title: nil,
      cells: [
        { title: '' },
        { title: sign_in_out_title ,
          action: :sign_in_out_button,
        }, 
        { title: 'Sign Up',
          action: :sign_up_button,
        },
        add_credit_card_menu
      ]
    }]
  end

  def add_credit_card_menu
    if Auth.signed_in?
      { title: "Add Credit Card", action: :add_credit_card_action }
    end
  end

  def sign_in_out_title
    if Auth.signed_in?
      "Logout"
    else
      "Sign In"
    end
  end

  def sign_in_out_button
    if Auth.signed_in?
      sign_out_button
    else
      sign_in_button
    end
  end

  def sign_in_button
    open Account::SignInScreen.new(nav_bar: true)
  end

  def sign_up_button
    open Account::SignUpScreen.new(nav_bar: true)
  end

  def sign_out_button
    Auth.sign_out do
      app.delegate.open_authenticated_root
    end
  end

  def add_credit_card_action
    open AddCreditCardScreen.new(nav_bar: true)
#    open PaymentViewController.new
#    mp StripeConnection.connectionWithPublishableKey("pk_test_APfRAnKNxAO78IG481nvbXqq")
  end


  def swap_center_controller(screen_class)
    # Just use screen_class if you don't need a navigation bar
    app_delegate.menu.center_controller = screen_class
  end
  

  # You don't have to reapply styles to all UIViews, if you want to optimize, another way to do it
  # is tag the views you need to restyle in your stylesheet, then only reapply the tagged views, like so:
  #   def logo(st)
  #     st.frame = {t: 10, w: 200, h: 96}
  #     st.centered = :horizontal
  #     st.image = image.resource('logo')
  #     st.tag(:reapply_style)
  #   end
  #
  # Then in will_animate_rotate
  #   find(:reapply_style).reapply_styles#

  # Remove the following if you're only using portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end
end

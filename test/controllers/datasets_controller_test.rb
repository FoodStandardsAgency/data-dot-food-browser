# frozen_string_literal: true

require 'test_helper'

# :nodoc:
class DatasetsControllerTest < ActionDispatch::IntegrationTest
  describe 'DatasetsController' do
    describe 'years controls' do
      it 'should include a "more years" action' do
        VCR.use_cassette('datasets_controller_test', record: :new_episodes) do
          get '/datasets'

          assert_select('legend', 'Years')
          assert_select('a.c-all-years-link', /more years.*/)
        end
      end

      it 'should not include a "more years" action if the user has selected all years' do
        VCR.use_cassette('datasets_controller_test', record: :new_episodes) do
          get('/datasets', params: { years: 'all' })

          assert_select('legend', 'Years')
          _(css_select('a.c-all-years-link')).must_be_empty
          _(css_select('.u-focus-on-load')).must_be_empty
        end
      end

      it 'should include a focus node if the user action is "more"' do
        VCR.use_cassette('datasets_controller_test', record: :new_episodes) do
          get('/datasets', params: { years: 'all', user_action: 'more' })

          assert_select('legend', 'Years')
          assert_select('.u-focus-on-load')
        end
      end
    end
  end
end

describe "User can manage quest", type: :feature do
    before do
        Quest.destroy_all
    end

    context "when a user be in the home page" do
        before do
            go_to_home_page
        end

        it "should see home detail on the home page" do
            should_see_title_on_home_page
            should_see_quest_form
        end

        it "allows user to create a new quest" do
            fill_in_the_quest_name_field_with "Test Enter Quest Name"
            click_the_submit_button
            should_clear_form
        end
    end

    context "when a quest exists" do
        let!(:quest) { Quest.create(name: "Test Quest", is_done: false) }

        before do
            go_to_home_page
        end

        it "should see the quest on the home page" do
            expect_to_see_a_quest
        end

        it "allows user to delete a quest" do
            click_delete_button
            expect_quest_to_be_deleted
        end

        it "allows user to update quest by click checkbox" do
            click_checkbox
            expect_checkbox_checked
        end
    end
end

def go_to_home_page
    visit root_path
end

def click_checkbox
    find("[data-testid='quest-checkbox-#{quest.id}']").click
end

def expect_checkbox_checked
    expect(find("[data-testid='quest-checkbox-#{quest.id}']")).to be_checked
end

def click_delete_button
    find("[data-testid='quest-delete-button-#{quest.id}']").click
end

def expect_to_see_a_quest
    new_quest = find("[data-testid='quest-name-#{quest.id}']")
    expect(new_quest.text).to eq("Test Quest")
end

def expect_quest_to_be_deleted
    expect(page).not_to have_selector("[data-testid='quest-name-#{quest.id}']")
end

def should_see_title_on_home_page
    title = find("[data-testid='boss-name']")
    expect(title.text).to eq("Boss|")
end

def should_see_quest_form
    form = find("[data-testid='quest-form']")
    name_field = find("[data-testid='quest-form-name']")
    submit_button = find("[data-testid='quest-form-submit']")
    expect(form).to be_visible
    expect(name_field).to be_visible
    expect(submit_button).to be_visible
end

def fill_in_the_quest_name_field_with(name)
    name_field = find("[data-testid='quest-form-name']")
    name_field.fill_in with: name
end

def click_the_submit_button
    submit_button = find("[data-testid='quest-form-submit']")
    submit_button.click
end

def should_clear_form
    expect(find("[data-testid='quest-form-name']")).to have_content("")
end

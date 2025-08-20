describe "User can see brag document page", type: :feature do
    context "when a user be in the home page and click my brag document button" do
        before do
            go_to_home_page
            click_my_brag_document_button
        end

        it "should see brag document page" do
            should_see_brag_document_page_with_title "Boss (2025)"
        end
    end

    context "when a user be in the brag document page" do
        before do
            go_to_brag_document_page
        end

        it "allows user to go back to quests page" do
            click_back_to_quests_button
            should_see_title_on_home_page
        end
    end
end

def click_my_brag_document_button
    find("[data-testid='my-brag-document-button']").click
end

def should_see_brag_document_page_with_title(title)
    expect(find("[data-testid='brag-document-title']").text).to eq(title)
end

def go_to_brag_document_page
    visit brag_path
end

def click_back_to_quests_button
    find("[data-testid='back-to-quests-button']").click
end

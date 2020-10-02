visited_links = []
home_links = []

def visit_internal_links(excluded_links)
    links = page.all('a', visible: false).map { |a| a['href'] }
    links.each do |i|
        if i and i.start_with? "http://127"
            unless (excluded_links.include? i or i.end_with? "LICENSE") 
                visit i
                if page.has_css?('h2', wait: 0)
                    expect(find('h2', match: :first).text).not_to eq('Something broke.')
                end
                excluded_links << i
            end
        end
    end
    return excluded_links
end

describe "tests", type: :feature, js: true do

    it "404 raises error" do
        visit 'http://127.0.0.1:8200/nope'
        expect(find('h2', match: :first).text).to eq('Something broke.')
    end

    it "test homepage links (max-depth=1)" do
        visit 'http://127.0.0.1:8200/'
        home_links = page.all('a', visible: false).map { |a| a['href'] }
        visited_links = visit_internal_links(visited_links)
    end

    it "test homepage links (max-depth=2)" do
        for link in home_links
            if link.start_with? "http://127"
                visit link
                visited_links = visit_internal_links(visited_links)
            end
        end
    end

  end

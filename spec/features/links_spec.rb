visited_links = []
home_links = []

def visit_internal_links(excluded_links)
    # visit all links on current page that are hosted on this server
    # and update list of visited links so we don't have to visit them >1x

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

    # Test that a 404 page can indeed render in the first place

    it "404 raises error" do
        visit 'http://127.0.0.1:8200/nope'
        expect(find('h2', match: :first).text).to eq('Something broke.')
    end

    # Test and collect every link on the homepage

    it "test homepage links (max-depth=1)" do
        visit 'http://127.0.0.1:8200/'
        home_links = page.all('a', visible: false).map { |a| a['href'] }
        visited_links = visit_internal_links(visited_links)
    end

    # Test every link on pages that themselves
    # are linked to on the homepage

    it "test homepage links (max-depth=2)" do
        for link in home_links
            if link.start_with? "http://127"
                visit link
                visited_links = visit_internal_links(visited_links)
            end
        end
    end

  end

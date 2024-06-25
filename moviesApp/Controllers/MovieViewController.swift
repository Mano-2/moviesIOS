//
//  ViewController.swift
//  moviesApp
//
//  Created by Manar Morabit on 31.05.2024.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate, UISearchBarDelegate{
    
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var table: UITableView!
    
    private var movies = [Movie]()
    @IBOutlet weak var searchBar: UISearchBar!
    private let movieService = MovieService()
    private var currentPage = 1
    var debounce_timer:Timer?
    private var isLoading = false
    private var selectedMovie: Movie?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.dataSource = self
        table.delegate = self
        searchBar.delegate = self
        searchBar.placeholder = "Search Movies"
        homeButton.layer.cornerRadius = 20

        fetchPopularMovies(page: currentPage)
    }
   
    
    
    
    
    
    private func fetchPopularMovies(page: Int) {
        guard !isLoading else { return }
               isLoading = true
               
                let pageSize = 20
        
        movieService.getPopularMovies(page: page, pageSize: pageSize) { [weak self] result in
                   guard let self = self else { return }
                   self.isLoading = false
                   switch result {
                   case .success(let movies):
                       if page == 1 {
                           self.movies = movies
                       } else {
                           self.movies.append(contentsOf: movies)
                       }
                       self.table.reloadData()
                       self.currentPage += 1
                   case .failure(let error):
                       print("Failed to fetch movies: \(error)")
                   }
               }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let offsetY = scrollView.contentOffset.y
         let contentHeight = scrollView.contentSize.height
         let height = scrollView.frame.size.height
         
         print("Scrolling... OffsetY: \(offsetY), ContentHeight: \(contentHeight), Height: \(height)") // Debugging print statement

         if offsetY > contentHeight - height * 2 {
             print("Fetching more movies") // Debugging print statement
             fetchPopularMovies(page: currentPage)
         }
     }
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        guard let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        // cell.iconImageView.image = UIImage(named: "russia")
        cell.label.text = movie.name
        let ratingText = String(format: "%.1f", movie.rating ?? "N/A")
        cell.ratingLabel.text = "\(ratingText) ★"
        movie.posterUrl(posterPath: movie.posterPath) { imageData in
            if let data = imageData {
                let image = UIImage(data: data)
                cell.iconImageView.image = image
            }
            else {
                       // If data is nil, set a placeholder image or handle the absence of image as per your app's design
                       cell.iconImageView.image = UIImage(named: "placeholder_image")
                   }
        }
                
        
        //  cell.configure(with: movie)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          selectedMovie = movies[indexPath.row]
        loadMovieDetailsAndSegue(movie: selectedMovie)
        print(selectedMovie?.id ?? 1)
        tableView.deselectRow(at: indexPath, animated: true)

      }
  
    private func loadMovieDetailsAndSegue(movie: Movie?) {
          guard let movie = movie else { return }
          movie.posterUrl(posterPath: movie.posterPath) { [weak self] _ in
              DispatchQueue.main.async {
                  
                  self?.performSegue(withIdentifier: "showMovieDetail", sender: self)
              }
          }
      }
    
    
    // MARK: - Search delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debounce_timer?.invalidate()
        debounce_timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            guard !searchText.isEmpty else {
                       
                self.table.reloadData()
                       return
                   }
            self.movieService.searchMovies(searchTerm: searchText) {[weak self] result in
                switch result{
                case .success(let movies):
                    self?.movies = movies
                    self?.table.reloadData()
                case .failure(let error):
                               print("Failed to search movies: \(error)")
                }
                
            }
            print("Search text changed: \(searchText)")

        }
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                   searchBar.resignFirstResponder()
        }
     
        
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != ""{
            return true
        }else {
            
            return false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text{
            movieService.searchMovies(searchTerm: searchText){ [weak self] result in
                switch result{
                case .success(let movies):
                    self?.movies = movies
                    self?.table.reloadData()
                case .failure(let error):
                    print("Failed to search movies: \(error)")

                }
            }
            
        }
        searchBar.text = ""
       
    }
    //MARK: - Action Outlets & Segues
    
    @IBAction func homePressed(_ sender: UIButton) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        // Restore the original movie list
        fetchPopularMovies(page: 1)
        print("Done")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.movie = selectedMovie
            }
        }
    }
}

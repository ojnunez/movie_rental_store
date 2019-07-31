import { Component, OnInit } from '@angular/core';
import { RestService } from '../rest.service';
import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { map, catchError, tap } from 'rxjs/operators';

import { ActivatedRoute, Router } from '@angular/router';

import { MovieComponent } from '../movies/movie.component';


@Component({
  selector: 'app-movies',
  templateUrl: './movies.component.html',
  styleUrls: ['./movies.component.sass'],
  providers: [MovieComponent]

})
export class MoviesComponent implements OnInit {

  movies: {};
  pageOfItems: {};

  url = "https://space-movie-rental-store.herokuapp.com/users/api_v1/";
  constructor(public rest:RestService, private http: HttpClient, private route: ActivatedRoute, private router: Router) { }

  //ngOnInit() {
  //  this.getMovies();
  //}

  // TO DO, form search for other params and sort
  ngOnInit() {
    // load page based on 'page' query param or default to 1
    this.route.queryParams.subscribe(x => this.getMovies(x.page || 1, null, null));
  }

  // Put it on common file
  private extractData(res: Response) {
    let body = res;
    return body || { };
  }

  private getMovies(page, query, like){
    return this.http.get(this.url + `movies?page=${page}`)
      .pipe(map(this.extractData))
      .subscribe((data: []) => {
        console.log(data);
        this.movies = data;
      });
  }

  onChangePage(pageOfItems: {}) {
    // update current page of items
    this.pageOfItems = pageOfItems;
  }



  //getMovies() {
  //  this.movies = [];
  //  this.rest.getMovies().subscribe((data: {}) => {
  //    console.log(data);
  //    this.movies = data;
  //  });
  //}

  //add() {
    //this.router.navigate(['/movie-add']);
  //}

  //delete(id) {
  //  this.rest.deleteMovie(id)
  //    .subscribe(res => {
  //        this.getMovies();
  //      }, (err) => {
  //        console.log(err);
  //      }
  //    );
  //}

}

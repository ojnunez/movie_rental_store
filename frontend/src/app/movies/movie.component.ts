import { Component, OnInit } from '@angular/core';
import { RestService } from '../rest.service';
import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { map, catchError, tap } from 'rxjs/operators';

import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-movie-detail',
  templateUrl: './movie.component.html',
  styleUrls: ['./movies.component.sass']
})
export class MovieComponent implements OnInit {

  movie:any;

  constructor(public rest:RestService, private http: HttpClient, private route: ActivatedRoute, private router: Router) { }

  ngOnInit() {
    this.route.queryParams.subscribe(x => this.getMovie(this.route.snapshot.params['id']));
  }

  private extractData(res: Response) {
    let body = res;
    return body || { };
  }

  private getMovie(id){
    return this.http.get(this.url + `movies/${id}`)
      .pipe(map(this.extractData))
      .subscribe((data: []) => {
        console.log(data);
        this.movie = data;
      });
  }


}

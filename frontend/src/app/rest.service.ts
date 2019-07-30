import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { map, catchError, tap } from 'rxjs/operators';

const endpoint = 'http://localhost:3000/users/api_v1/';
const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type':  'application/json'
  })
};


@Injectable({
  providedIn: 'root'
})
export class RestService {

  constructor(private http: HttpClient) { }

  private extractData(res: Response) {
    let body = res;
    return body || { };
  }

  getMovie(id): Observable<any> {
    return this.http.get(endpoint + 'movies/' + id).pipe(
      map(this.extractData));
  }

  //updateMovie (id, movie): Observable<any> {
  //  return this.http.put(endpoint + 'movies/' + id, JSON.stringify(movie), httpOptions).pipe(
  //    tap(_ => console.log(`updated movie id=${id}`)),
  //    catchError(this.handleError<any>('updateMovie'))
  //  );
  //}

  private handleError<T> (operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
      // TODO: better job of transforming error for user consumption
      console.log(`${operation} failed: ${error.message}`);

      // Let the app keep running by returning an empty result.
      return of(result as T);
    };
  }

}

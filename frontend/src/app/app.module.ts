import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HttpClientModule } from '@angular/common/http';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { RouterModule, Routes } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { JwPaginationComponent } from 'jw-angular-pagination';

import { AngularTokenModule } from 'angular-token';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { MoviesComponent } from './movies/movies.component';
import { MovieComponent } from './movies/movie.component';

const appRoutes: Routes = [
  {
    path: 'movies',
    component: MoviesComponent,
    data: { title: 'Movie List' }
  },

  {
    path: 'movies/:id',
    component: MovieComponent,
    data: { title: 'Movie Details' }
  },

  //{
  //  path: 'sign_up',
  //  component: UserRegisterComponent,
  //  data: { title: 'Sign up' }
  //},

  //{
  //  path: 'sign_in',
  //  component: UserRegisterComponent,
  //  data: { title: 'Sign in' }
  //},

  { path: '',
    redirectTo: '/movies',
    pathMatch: 'full'
  }

];

@NgModule({
  declarations: [
    AppComponent,
    JwPaginationComponent,
    MoviesComponent,
    MovieComponent
  ],
  imports: [
    RouterModule.forRoot(appRoutes),
    FormsModule,
    BrowserModule,
    NgbModule,
    HttpClientModule,
    AppRoutingModule
  ],
  providers: [AngularTokenModule],
  bootstrap: [AppComponent]
})
export class AppModule {  }

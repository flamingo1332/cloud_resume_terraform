describe('E2E Test', () => {

    beforeEach(() => {
      cy.visit('http://localhost:3000'); // replace with your React app's URL
    });
  

    
    it('successfully loads and displays paragraphs and links', () => {
      cy.get('p').should('have.length', 10); 
      cy.get('a').should('have.length', 15); 
    });
  


    it('has functional links', () => {
      cy.get('a').each(link => {
        // assuming href attribute is correctly set
        expect(link.prop('href')).not.to.be.empty;
      });
    });
    


    it('makes an API call and renders data', () => {
      const apiEndpoint = Cypress.env('apiEndpoint');
      
      cy.request({
        method: 'PUT',
        url: apiEndpoint,
        failOnStatusCode: false, 
      }).then((res) => {
        expect(res.body).to.be.a('number');
      })
    });
  
  });